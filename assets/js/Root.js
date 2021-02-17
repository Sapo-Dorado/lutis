import React from "react"
import HomePage from "./main/pages/HomePage";
import PostPage from "./main/pages/PostPage";
import UsernamePage from "./main/pages/UsernamePage";
import UserInfo from "./main/utils/UserInfo"

export default class Root extends React.Component {
  constructor(props) {
    super(props)

    const searchParams = new URLSearchParams(window.location.search)
    const email = searchParams.get("email")
    const token = searchParams.get("token")
    const username = searchParams.get("username")

    history.replaceState({}, "", "/")
    if(token !== null) {
      UserInfo.setToken(token)
      UserInfo.setEmail(email)
      if(username == "") {
        this.state = {page: "username"}
      } else {
        this.state = {page: "posts"}
      }
    } else {
      this.state = {page: "home"}
    }
  }
  render() {
    let page;
    if(this.state.page === "home") {
      page = <HomePage />
    } else if (this.state.page == "username") {
      page = <UsernamePage />
    } else {
      page = <PostPage />
    }
    return (
      <>
        {page}
      </>
    )
  }
}