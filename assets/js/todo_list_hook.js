const TodoListHook = {
    mounted() {
        console.log("mounted");
        this.handleEvent("delete_todo_event", (data) => {
            // use data to update your component
            console.log("delete_todo: list-item-" + data.todo.id);
            var lis = document.querySelectorAll('#list-item-' + data.todo.id);
            for(var i=0; i < lis.length; i++) {
                this.el.removeChild(lis[i]);
            }
        });
    },
    updated() {
        console.log("updated");
    },
    destroyed() {
        console.log("updated");
    }
}

export default TodoListHook;