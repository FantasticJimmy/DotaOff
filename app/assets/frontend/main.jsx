import React from 'react';
import ReactDOM from 'react-dom';
import Content from './content'
import SideNav from './sidenav';

class Main extends React.Component{

  constructor(props) {
    super(props);
    this.state = {chosenTab: null}
  }

  chosen = (tab) => {
    this.setState({
      chosenTab: tab
    });
  };

  render(){
    return(
      <div>
        <div className="row">
          <SideNav chosen={this.chosen}/>
          <Content tab={this.state.chosenTab}/>
        </div>
      </div>
      );
  }
}

let documentReady = () =>{
  let reactNode= document.getElementById('dashboard_index');
  if(reactNode){
    ReactDOM.render(
      <Main />, reactNode
        )
  }
}

$(documentReady)