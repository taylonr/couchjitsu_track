$(function () {
    function getCSRFTokenValue() {
        return $('input[name="_csrf_token"]').val();
    }

    $('#suggestions').on('click', 'a', function (ev) {
        const link = $(ev.currentTarget);
        const date = $('#record_date').val();

        const data = {
            record: {
                activity_id: link.data('id'),
                date: date,
                duration: link.data('duration')
            },
            _csrf_token: getCSRFTokenValue()
        }

        $.ajax({
            method: 'post',
            data: data,
            url: '/activityfeed/new'
        }).done(function () {
            location.search = '?date=' + date;
        });
    });

    $('#record_date').on('change', () => {
        $.ajax({
            url: '/activityfeed/suggestions/' + $('#record_date').val()
        }).done((response) => {
            $('#suggestions').html(response);
        });

        $.ajax({
            url: '/activityfeed/records/' + $('#record_date').val()
        }).done((response) => {
            $('.ui.centered.feed').html(response);
        });
    });
});