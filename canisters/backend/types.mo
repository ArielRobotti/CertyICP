import List "mo:base/List";

module {

    ////////////////// Instituciones ////////////////////////////////

    public type ID = Text;

    public type Institution = {
        id : Text;
        institutionName : Text;
        email : Text;
        country : Text;
        temaLeader : { name : Text; email : Text; pid : Principal };
        socialNetworks : [SocialNetwork];
        team : [Principal]; // los miembros preferentemente tienen que ser usuarios para poder extraer y visualizar sus nombres
        certyBatchIDs : [BatchID];
        storage : [Document];
        verified : Bool
    };

    public type SignUpInstitution = {
        id : Text;
        institutionName : Text;
        email : Text;
        country : Text;
        temaLeader : { name : Text; email : Text; pid : Principal };
    };

    public let initDefaultValuesInstitution = {
        socialNetworks : [SocialNetwork] = [];
        team : [Principal] = [];
        certyBatchIDs : [BatchID] = [];
        storage : [Document] = [];
        verified = false
    };

    /////////////////////////////////////////////////////////////////////

    public type Date = {
        day : Nat8;
        month : Nat8;
        year : Nat16
    };

    // public type BootcampCertify = {
    //     btID: Text;
    //     title : Text;
    //     description : Text;
    //     startDate : Date;
    //     endDate : Date;
    //     location : Text;
    //     price : Float;
    //     topicsCovered : [Text];
    //     instructors : [Text];
    //     prerequisites : Text;
    //     format : Text; // e.g., Online, In-person, Hybrid
    //     certification : Bool;
    //     maxParticipants : ?Nat;
    //     language : Text;
    //     website : Text;
    //     applicationDeadline : Date
    // };  

    // public type Hackathon = {
    //     id : Text;
    //     title : Text;
    //     organizer : ID;
    //     durationDays : Nat;
    //     description : Text;
    //     applicationDeadline : Date;
    //     startDate : Date;
    //     endDate : Date;
    //     location : Text;
    //     prizePool : Float;
    //     tracks : [Text];
    //     sponsors : [Text];
    //     registrationFee : ?Float;
    //     teamSizeLimit : ?Nat;
    //     judgingCriteria : [Text];
    //     website : Text;
    //     contactInfo : Text;
    //     eligibilityCriteria : Text;
    //     schedule : Text;
    //     workshops : [Text];
    //     mentors : [Text];
    //     awards : [Text];
    //     certification : Bool
    // };

    public type SocialNetwork = {
        #Discord : Text; // "https://discord.com";
        #LinkedIn : Text; // "https://www.linkedin.com";
        #Twitter : Text; // "https://twitter.com";
        #Medium : Text; // "https://medium.com/topic/programming";
        #GitHub : Text; // "https://github.com";
        #GitLab : Text; // "https://gitlab.com";
        #OpenChat : Text;
        #Hobbi : Text;
        #Bitbucket : Text; // "https://bitbucket.org";
        #StackOverflow : Text; // "https://stackoverflow.com";
        #Reddit : Text; // "https://www.reddit.com/r/programming";
        #HackerNews : Text; // "https://news.ycombinator.com";
        #Quora : Text; // "https://www.quora.com";
        #Facebook : Text; // "https://www.facebook.com/your-page";
        #Instagram : Text; // "https://www.instagram.com/your-profile";
        #YouTube : Text; // "https://www.youtube.com/c/your-channel";
        #Meetup : Text; // "https://www.meetup.com/your-group";
        #Telegram : Text; // "https://t.me/your-group";
        #Slack : Text; // "https://your-workspace.slack.com";
        #Mastodon : Text; // "https://mastodon.social/@your-profile";
        #Twitch : Text; // "https://www.twitch.tv/your-channel";
        #Clubhouse : Text; // "https://www.joinclubhouse.com/@your-profile";
        #ResearchGate : Text; // "https://www.researchgate.net/profile/your-profile";
        #Devto : Text; // "https://dev.to";
        #Xing : Text; // "https://www.xing.com";
    };

    //////////////////////// Certificaciones ////////////////////////

    public type CertyID = Text;
    public type BatchID = Text;

    public type CertysBatch = {
        batchId: BatchID;
        title : Text;
        description : Text; 
        dateCreation : Int;
        kind : KindCertificate;
        format : Format;  
        extraMetadata : { key : Text; value : Text };
        certifyingAuthority : Principal;
    };

    public type InitCertysBatch = {
        title : Text;
        description : Text; 
        kind : KindCertificate;
        externalCanisterNFT: Bool;
        extraMetadata : { key : Text; value : Text };
    };

    public type Certy = {
        batchId: BatchID;
        certyId: CertyID;
        completionDate : Int;
        urlAsset : Text;
    };

    type Format = {
        #Pdf : Blob;
        #Image : Blob;
        #Nft : Principal; //Principal ID donde se desplegó la coleccion de certificados
    };

    type Prize = {
        #FisrtPlace;
        #SecondPlace;
        #ThirdPlace;
        #CustomPrize: {k: Text; v: Text};
        #Award : Text
    };

    type KindCertificate = {
        #Attendance;
        #Mentoring;
        #Participation;
        #Bootcamp;
        #Hackathon : Prize;
    };

    /////////////////// Usuarios ///////////////////////////////////

    public type SignUpUser = {
        name : Text;
        email : ?Text;
        avatar : ?Blob
    };

    public type User = {
        userId : Text;
        name : Text;
        email : ?Text;
        walletRecipient : [{ pid : Principal; aid : ?Text }]; //Plug wallet e.g.
        socialNetworks : [SocialNetwork];
        avatar : ?Blob;
        isUserVerified : Bool;
        certificatesID : [CertyID];
        storage : [Document]
    };

    public let initDefaultValuesUser = {
        socialNetworks : [SocialNetwork] = [];
        isUserVerified = false;
        certificatesID : [CertyID] = [];
        walletRecipient : [{ pid : Principal; aid : ?Text }] = [];
        storage : [Document] = []
    };

    public type Document = {
        title : Text;
        contentType : Text;
        body : Blob;
        access : { #Public; #Private };
        uploadDate : Int
    };

}
