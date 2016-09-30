var NotebookItem = React.createClass({
  getInitialState: function () {
    return {name: this.props.name, value: this.props.value}
  },
  handleSubmit: function (e) {
    e.preventDefault();
    var data = { notebook: {} }
    data.notebook[this.props.slug] = this.state.value
    $.ajax({
      data: data,
      url: '/profile/update',
      type: 'PUT',
      dataType: 'json',
      success: function (data) {
        this.setState({ value: data.notebook[this.props.slug] });
        this.endEdit();
      }.bind(this)
    });
  },
  onChange: function (e) {
    this.setState({ value: e.target.value });
  },
  initEdit: function () {
    this.setState({ editing: true })
  },
  endEdit: function () {
    this.setState({ editing: false })
  },
  render: function () {
    return (
      <div className={'row notebook-item ' + (this.state.editing ? 'editing' : '')}>
        <form onSubmit={this.handleSubmit}>
          <label htmlFor={this.state.slug}>{this.state.name}</label>
          <input name={this.state.slug} type='text' defaultValue={this.props.value} onChange={this.onChange} />
          <p>{this.state.value}</p>
        </form>
        <div className='notebook-edit-trigger'>
          <div className='edit-enable' onClick={this.initEdit}>&#x270e;</div>
        </div>
      </div>
    )
  }
});
var Notebook = React.createClass({
  getInitialState: function () {
    return {items: this.props.items}
  },
  render: function () {
    return (
      <div>
        <h3>Notebook</h3>
        {this.props.items.map(function(item) {
          return <NotebookItem key={item.slug} slug={item.slug} name={item.name} value={item.value} />
        })}
      </div>
    )
  }
});
