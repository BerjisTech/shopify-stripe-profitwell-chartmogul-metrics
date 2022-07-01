jQuery(document).ready(($) => {
    $('.usernotes').on('input', () => {
        $.ajax({
            url: $('.usernotes').attr('notes_link'),
            data: {
                'authenticity_token': $('[name="csrf-token"]')[0].content,
                'note': $('.usernotes').val(),
                'user_id': 0,
            },
            method: 'POST',
            success: (response) => { /** inform(response.message, 'Info') **/ },
            error: (error) => {
                console.log(error)
            }
        })
    })

    $(function () {
        $(`[id^="task_sortable"]`).sortable({
            update: (e, ui) => {
                var taskOrder = $(e.target).sortable('toArray').filter(String, Number, Boolean)
                re_prioritize_offers(taskOrder)
            },
            start: (e, ui) => { },
            stop: (e, ui) => { }
        });
    });

    function re_prioritize_offers(tasks) {
        $.ajax({
            url: reprioritize_tasks_path,
            method: 'POST',
            data: {
                'authenticity_token': $('[name="csrf-token"]')[0].content,
                'tasks': tasks
            },
            success: (response) => {
                console.log(response)
            },
            error: (error) => {
                console.log(error)
            }
        })
    }
})