function skillsNew() {

    $.ajax({
        url: "/skill_types",
        beforeSend: function( xhr ) {
            //xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
        }
    })
        .done(function( data ) {
            var getMatches = function(skill_types, substring) {
                var matches = _.filter(
                    skill_types,
                    function( skill_type ) { return skill_type.name.toLowerCase().indexOf(substring.toLowerCase()) !== -1; }
                );
                return matches
            };
            $("#skill_skill_type_name").typeahead({
                source: function (query, process) {
                    console.log("hey")
                    process(getMatches(data.skill_types, query))
                },
                displayText: function(item) {
                    return item.name
                },
                updater: function (item) {
                    $("#skill_skill_type").val(item.id)
                    return item.name;
                }
            })
        });
}

$(document).on('page:change', skillsNew)