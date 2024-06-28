module {

    public type Certificate = {
        format: Format;
        kind: KindCertificate;
        certifyingAuthority: Principal;
        title: Text;
        description: Text;
        url: Text;
    };
    type Format = {
        #Pdf: Blob;
        #Image: Blob;
        #Nft: {canisterId: Principal; tokenId: Text};
    };

    type KindCertificate = {
        #Poap;
        #Bootcamp;
        #HackathonAwards: Text; //e.g. 1º Prize, 2ª Prize, mention.. etc

    };

    public type User = {
        userId: Text;
        name : Text;
        email : ?Text;
        certificatesID: [Certificate];
        avatar: ?Blob;
    };
    public type SignUpUser = {
        name : Text;
        email : ?Text;
        avatar: ?Blob;
    };

}