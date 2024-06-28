import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Types "types";
import Map "mo:map/Map";
import {phash} "mo:map/Map";

actor {
    type User = Types.User;
    type SignUpUser = Types.SignUpUser;
    stable let users = Map.new<Principal, User>();

    stable var currentUserId = 123456: Nat;
    func generateId(): Text {
        currentUserId += 1;
        "U" # Nat.toText(currentUserId)
    };

    func isUser (a: Principal): Bool {
        switch(Map.get(users, phash, a)) {
            case null {false};
            case _ { true}
        }
    };

    public shared ({caller}) func signUp(init: SignUpUser): async ?User {
        assert Principal.isAnonymous(caller);
        assert (not isUser(caller));
        let newUser = {
            userId = generateId();
            name = init.name;
            email = init.email;
            avatar = init.avatar;
            certificatesID: [Types.Certificate] = []
        };
        Map.put<Principal, User>(users, phash, caller, newUser);


    };
     

    public query ({ caller }) func usuarioHardcodeado() : async ?Types.User {
        null
    };

}
