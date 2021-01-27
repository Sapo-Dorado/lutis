import React from "react"
import HomePage from "./main/pages/HomePage";
import PostIndexPage from "./main/pages/PostIndexPage";
import UserInfo from "./main/utils/UserInfo"

export default class Root extends React.Component {
  constructor(props) {
    super(props)

    const searchParams = new URLSearchParams(window.location.search)
    const email = searchParams.get("email")
    const token = searchParams.get("token")
    if(token !== null) {
      UserInfo.setToken(token)
      UserInfo.setEmail(email)
      this.state = {page: "posts"}
    } else {
      this.state = {page: "home"}
    }
  }
  render() {
    let page;
    if(this.state.page === "home") {
      page = <HomePage />
    } else {
      page = <PostIndexPage />
    }
    return (
      <>
        {page}
      </>
    )
  }
}