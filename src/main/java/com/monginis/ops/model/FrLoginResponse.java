
package com.monginis.ops.model;


public class FrLoginResponse {

    private ErrorMessage errorMessage;
    private Franchisee franchisee;

    public ErrorMessage getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(ErrorMessage errorMessage) {
        this.errorMessage = errorMessage;
    }

    public Franchisee getFranchisee() {
        return franchisee;
    }

    public void setFranchisee(Franchisee franchisee) {
        this.franchisee = franchisee;
    }

	@Override
	public String toString() {
		return "FrLoginResponse [errorMessage=" + errorMessage + ", franchisee=" + franchisee + "]";
	}

    
    
    
}
