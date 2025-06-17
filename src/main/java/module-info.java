module org.example.dchatserverview {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.web;

    requires org.controlsfx.controls;
    requires com.dlsc.formsfx;
    requires net.synedra.validatorfx;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.bootstrapfx.core;
    requires eu.hansolo.tilesfx;
    requires com.fasterxml.jackson.datatype.jsr310;
    requires com.fasterxml.jackson.databind;
    requires java.sql;

    opens org.example.dchatserverview to javafx.fxml;
    opens org.example.dchatserverview.JSON to com.fasterxml.jackson.databind;
    exports org.example.dchatserverview;
    exports org.example.dchatserverview.UIClasses to com.fasterxml.jackson.databind;
}