import Principal "mo:base/Principal";
import Types "types";
import Mat "mo:map/Map";

actor {
    

    public query ({ caller }) func usuarioHardcodeado() : async ?Types.User {
        ?{
            userId = 0;
            name = "Usuario harcodeado";
            email = "harcodeado@gmail.com";
            principalID = caller
        }
    };

}
