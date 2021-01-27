import React from "react"
import LoginButton from "../components/LoginButton"


export default class HomePage extends React.Component {
  render() {
    return (
      <>
        <p>Welcome to Lutis!</p>
        <LoginButton />
      </>
    )
  }
}