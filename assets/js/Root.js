import React from "react"
import LoginButton from "./main/components/LoginButton"

export default class Root extends React.Component {
  render() {
    return (
      <>
        <p>Welcome to Lutis!</p>
        <LoginButton />
      </>
    )
  }
}