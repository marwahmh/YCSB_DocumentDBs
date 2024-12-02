package couchdb;

import site.ycsb.Status;

public class ExtendedStatus extends Status {
    public static final Status JSON_PARSING_FAULT = new Status("JSON_PARSING_FAULT", "JSON parsing failure");

    public static final Status UPDATE_CONFLICT = new Status("UPDATE_CONFLICT", "Conflict during update operation");

    // Constructor to match the parent class's requirements
    public ExtendedStatus(String name, String description) {
        super(name, description);
    }


}
