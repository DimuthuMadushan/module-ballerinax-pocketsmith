// Reviews a month of budget performance: resolves the authorised user, lists their
// accounts and summarises budget analysis per category.

import ballerina/io;
import ballerinax/pocketsmith;

configurable string developerKey = ?;
configurable string startDate = ?;
configurable string endDate = ?;

public function main() returns error? {
    pocketsmith:Client pocketsmithClient = check new ({auth: {xDeveloperKey: developerKey}});

    pocketsmith:User user = check pocketsmithClient->getAuthorisedUser();
    int userId = check user?.id.ensureType();
    io:println(string `Reviewing budget for ${user?.name ?: "unknown user"} (id ${userId})`);

    pocketsmith:Account[] accounts = check pocketsmithClient->listUserAccounts(userId);
    foreach pocketsmith:Account account in accounts {
        io:println(string `Account: ${account?.title ?: "untitled"} - balance ${account?.currentBalance ?: 0d} ${account?.currencyCode ?: ""}`);
    }

    pocketsmith:BudgetAnalysisPackage[] packages = check pocketsmithClient->getUserBudgetSummary(
        userId, period = "months", interval = 1, startDate = startDate, endDate = endDate);
    foreach pocketsmith:BudgetAnalysisPackage budgetPackage in packages {
        string categoryTitle = budgetPackage.category?.title ?: "all categories";
        pocketsmith:BudgetAnalysis? expense = budgetPackage.expense;
        if expense is () {
            continue;
        }
        decimal forecast = expense?.totalForecastAmount ?: 0d;
        decimal actual = expense?.totalActualAmount ?: 0d;
        string status = actual > forecast ? "over budget" : "within budget";
        io:println(string `${categoryTitle}: forecast ${forecast}, actual ${actual} (${status})`);
    }
}
