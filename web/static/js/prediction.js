$(function () {
    function getCSRFTokenValue() {
        return $('input[name="_csrf_token"]').val();
    }

    $('ul').on('click', 'a', function (ev) {
        var link = $(ev.currentTarget);

        var data = {
            record: {
                activity_id: link.data('id'),
                date: $('#record_date').val(),
                duration: link.data('duration')
            },
            _csrf_token: getCSRFTokenValue()
        }

        $.ajax({
            method: 'post',
            data: data,
            url: '/activityfeed/new'
        }).done(function () {
            location.reload();
        });
    });
});