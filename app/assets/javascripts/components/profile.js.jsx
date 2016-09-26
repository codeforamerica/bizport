var NotebookItem = React.createClass({
  getInitialState: function () {
    return {name: this.props.name, value: this.props.value}
  },
  handleSubmit: function (e) {
    e.preventDefault();
    var data = { notebook: {} }
    data.notebook[this.state.name] = this.state.value
    $.ajax({
      data: data,
      url: '/profile/update',
      type: 'PUT',
      dataType: 'json',
      success: function (data) {
        this.setState({ value: data.value })
      }.bind(this)
    });
  },
  onChange: function (e) {
    this.setState({ value: e.target.value });
  },
  render: function () {
    return (
      <form className='row' onSubmit={this.handleSubmit}>
        <label htmlFor={this.state.name}>{this.state.name}</label>
        <input name={this.state.name} type='text' defaultValue={this.state.value} onChange={this.onChange} />
      </form>
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
        {this.state.items.map(function(item) {
          return <NotebookItem key={item.id} name={item.name} value={item.value} />
        })}
      </div>
    )
  }
});
