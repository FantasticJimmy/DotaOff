import React from 'react'
import ContentDetail from './contentdetail'
let styles={
  content:{
    width: '90%'
  }
}
export default class Content extends React.Component{ 

  constructor(props){
    super(props)
  }
  conponentDidMount(){

  }
     
  render(){
    return( 
        <div className="col s10" > 
          <div className="card-panel">
            <ContentDetail tab={this.props.tab}/>
          </div>
        </div>
      )
  }
}