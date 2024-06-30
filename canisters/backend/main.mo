import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Types "types";
import Map "mo:map/Map";
import Result "mo:base/Result";
import { phash; thash } "mo:map/Map";
import {now} "mo:base/Time";

actor {
    type User = Types.User;
    type Institution = Types.Institution;

    type BatchID = Types.BatchID;
    type CertysBatch = Types.CertysBatch;
    type Certy = Types.Certy;

    stable let users = Map.new<Principal, User>();
    stable let institutions = Map.new<Principal, Institution>();
    stable let batchCertysMap = Map.new<BatchID, CertysBatch>();

    stable var currentUserId = 0;
    stable var currentInstitutionId = 0;
    stable var currentBatchId = 0;

    func generateId(prefix : Text) : Text {
        switch prefix {
            case "U" {
                currentUserId += 1;
                prefix # Nat.toText(currentUserId - 1)
            };
            case "I" {
                currentInstitutionId += 1;
                prefix # Nat.toText(currentInstitutionId - 1)
            };
            case "BCB" {
                currentBatchId += 1;
                prefix # Nat.toText(currentBatchId - 1)
            };
            case _ { "" }
        }
    };

    func isUser(p : Principal) : Bool {
        switch (Map.get(users, phash, p)) {
            case null { false };
            case _ { true }
        }
    };

    func isInstitution(p : Principal) : Bool {
        switch (Map.get(institutions, phash, p)) {
            case null { false };
            case _ { true }
        }
    };

    public shared ({ caller }) func signUp(init : Types.SignUpUser) : async ?User {
        assert Principal.isAnonymous(caller);
        assert (not isUser(caller));
        let newUser = {
            Types.initDefaultValuesUser with
            userId = generateId("U");
            name = init.name;
            email = init.email;
            avatar = init.avatar
        };
        Map.put<Principal, User>(users, phash, caller, newUser)
    };

    public shared ({ caller }) func registerInstitution(init : Types.SignUpInstitution) : async ?Institution {
        assert (isUser(caller));
        assert (not isInstitution(caller)); //Inicialmente un mismo principal podrá ser titular de una sola instituión
        let newInstitution = {
            Types.initDefaultValuesInstitution with
            id = generateId("I");
            institutionName = init.institutionName;
            temaLeader = init.temaLeader;
            email = init.email;
            country = init.country
        };
        Map.put(institutions, phash, caller, newInstitution)
    };

    // public shared ({ caller }) func createBootcamp(init: Bootcamp):async {#Ok: Text; #Err: Text}{
    //     let institution = Map.get(institutions, phash, caller);
    //     switch institution {
    //         case null{#Err("Registre su institución antes de crear un bootcamp.")};
    //         case (?inst){
    //             let btID = generateId("BT");
    //             let newBootcamp = {
    //                 init with
    //                 btID};
    //             ignore Map.put<Text, Bootcamp>(bootcamps, thash, btID, newBootcamp);
    //             #Ok(btID);
    //         }
    //     }
    // };

    ///////////////////////// Crear partida de certificaciones ///////////////////////////////

    public shared ({ caller }) func createCertysBatch(init : Types.InitCertysBatch) : async ?BatchID {
        let institution = Map.get<Principal, Institution>(institutions, phash, caller);
        switch institution {
            case null { null };
            case (?inst) {
                if (init.externalCanisterNFT) {
                    // let canisterIdCerty = await deployNftCerty(init);
                    // let batchId = generateId("BCB");
                    // let newBatch : CertysBatch = {
                    //     init with
                    //     batchId;
                    //     dateCreation = now();
                    //     format = #Nft(canisterIdCerty);
                    //     certifyingAuthority = caller;
                    // };
                    // ignore Map.put<BatchID, CertysBatch>(batchCertysMap, thash, batchId, newBatch);
                    return null
                };
                
                null
            }
        }

    };

    //////////////////// Despliegue de partida en canister externo ////////////////////////////
    // public shared ({ caller }) func deployNftCerty(init : Types.InitCertysBatch) : async Principal {
    //     Principal.fromText("2vxsx-fae");
    // };


}
