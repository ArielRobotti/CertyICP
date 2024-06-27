import React, { useEffect, useState } from "react"
import { Actor, HttpAgent } from '@dfinity/agent';
import { createClient } from "@connect2ic/core"
import { InternetIdentity, NFID } from "@connect2ic/core/providers"
import { ConnectButton, ConnectDialog, Connect2ICProvider, useCanister, useConnect } from "@connect2ic/react"
import "@connect2ic/core/style.css"

import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom"

import * as backend from "../src/declarations/backend"

function App() {
    interface User { 'userId' : bigint, 'name' : string, 'email' : string }
    const { isConnected, principal } = useConnect();
    const [backend] = useCanister("backend");
    const [userData, setUserData] = useState()

    
    useEffect(() => {
        if (isConnected) {
            getUserData()
        }
    }, [isConnected, backend]);

    const getUserData = async function ()  {
        const data = await backend.usuarioHardcodeado();
        if(data[0] != undefined){
            setUserData(data[0])
        }
        console.log("Data[0] ---> ", data[0])
        console.log("userData --> ", userData)
    }

    return (
        <>
            {isConnected && (
                <div>
                    <p>Connected as : {principal}</p>
                </div>
            )}
            <ConnectButton />
            <ConnectDialog />
        </>
    )
}
declare let process: {
    env: {
        DFX_NETWORK: string
        NODE_ENV: string
    }
}
const network = process.env.DFX_NETWORK || (process.env.NODE_ENV === "production" ? "ic" : "local");
const internetIdentityUrl = network === "local" ? "http://localhost:4943/?canisterId=rdmx6-jaaaa-aaaaa-aaadq-cai" : "https://identity.ic0.app"

const client = createClient({
    canisters: {
        backend,
    },
    providers: [
        new InternetIdentity({
            dev: true,
            providerUrl:
                internetIdentityUrl,
        }),
        new NFID()
    ],
    globalProviderConfig: {
        dev: true,
    },
})

export default () => (
    <Connect2ICProvider client={client}>
        <App />
    </Connect2ICProvider>
)
