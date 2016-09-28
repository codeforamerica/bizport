var ChecklistItem = React.createClass({
  getInitialState: function () {
    return { checked: this.props.checked }
  },
  onChange: function (e) {
    var isChecked = e.target.checked
    this.setState({ checked: isChecked })
    var data = { checklist_item: {} }
    data.checklist_item.id = e.target.value
    data.checklist_item.checked = isChecked
    $.ajax({
      data: data,
      url: '/checklist',
      type: 'PUT',
      dataType: 'json',
      success: function (data) {
        this.setState({ checked: data.checked })
      }.bind(this)
    });
  },
  render: function () {
    return (
      <li className='checklist-item'>
        <input type='checkbox' id={'checklist-'+this.props.id} name='checklist_items[]' value={this.props.id} defaultChecked={this.props.checked} onChange={this.onChange} />
        <label htmlFor={'checklist-'+this.props.id}>{this.props.text}</label>
      </li>
    )
  }
});
