trigger updateWon on A__c (before update) {
    updateWonHelper.updateField(trigger.new);
}