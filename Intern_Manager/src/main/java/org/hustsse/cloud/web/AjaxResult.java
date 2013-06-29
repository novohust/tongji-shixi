package org.hustsse.cloud.web;

public class AjaxResult {

    private Object result;
    private Object errorMsg;

    public AjaxResult(){
        super();
    }

    public AjaxResult(Object result){
        super();
        this.result = result;
    }

    public AjaxResult(Object result, String errorMsg){
        super();
        this.result = result;
        this.errorMsg = errorMsg;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public Object getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

}
