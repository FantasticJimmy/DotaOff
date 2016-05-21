import React from 'react'
let styles={

}
export default class ContentDetail extends React.Component{ 
  constructor(props){
    super(props)
  }
  conponentDidMount(){

  }
     
  render(){
    return( 
        <div> {this.props.tab ? this.props.tab : 'nothing chosen'} </div>
      )
  }
}