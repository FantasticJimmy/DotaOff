import React from 'react'
import Profile from './profile'
import ViewHistory from './viewhistory'
import StartTeam from './startteam'
import JoinTeam from './jointeam'

let styles={
  sideNavEach:{
    height: '100px',
    padding: "10px",
    textAlign:'center',
  },
}
export default class SideNav extends React.Component{ 
  chosen = (tab)=>{
    let that = this;
    this.props.chosen(tab)
  }
  render(){
    return( 
      <div className="collection col s2">
          <a className="collection-item" style={styles.sideNavEach} onClick={this.chosen}>
            <Profile />
             <i className="medium material-icons">contacts</i>
          </a>
          <a className="collection-item" style={{height: '120px', padding: "10px", textAlign:'center'}} onClick={this.chosen}>
            <ViewHistory />
            <i className="medium material-icons">video_library</i>
          </a>
          <a className="collection-item" style={styles.sideNavEach} onClick={this.chosen}>
            <StartTeam />
            <i className="medium material-icons">navigation</i>
          </a>
          <a className="collection-item" style={styles.sideNavEach} onClick={this.chosen}>
            <JoinTeam />
            <i className="medium material-icons">system_update_alt</i>
          </a>
      </div>
      )
  }
}