var ChecklistItem = React.createClass({
  getInitialState: function () {
    return { checked: this.props.completed, disabled: (this.props.disabled || false) }
  },
  onChange: function (e) {
    this.setState({ checked: e.target.checked })
    var data = {
      checklist_item: {
        id: this.props.id,
        completed: e.target.checked,
        disabled: this.state.disabled
      }
    }
    this.sync(data)
  },
  sync: function (data) {
    $.ajax({
      data: data,
      url: '/checklist',
      type: 'PUT',
      dataType: 'json',
      success: function (data) {
        this.setState({ checked: data.completed==='true', disabled: data.disabled==='true' })
      }.bind(this)
    });
  },
  toggleDisabled: function (e) {
    var data = {
      checklist_item: {
        id: this.props.id,
        completed: this.state.checked,
        disabled: !this.state.disabled
      }
    }
    this.sync(data)
  },
  render: function () {
    return (
      <li className={'checklist-item '+(this.state.disabled ? 'disabled' : 'enabled')} >
        <div className='checkbox-area'>
          <input type='checkbox' id={'checklist-'+this.props.id} value={this.props.id} defaultChecked={this.props.completed} onChange={this.onChange} />
          <label htmlFor={'checklist-'+this.props.id}>{this.props.text}</label>
        </div>
        <div className='checkbox-edit-triggers'>
          <div className={'checkbox-toggle enable'} onClick={this.toggleDisabled} >&#8853;</div>
          <div className={'checkbox-toggle disable'} onClick={this.toggleDisabled} >&#8854;</div>
        </div>
      </li>
    )
  }
});
var Checklist = React.createClass({
  render: function () {
    return (
      <ul>
        {this.props.items.map(function(item) {
          return <ChecklistItem key={item.id} id={item.id} text={item.item_text} completed={item.completed} disabled={item.disabled} />
        })}
      </ul>
    )
  }
});
