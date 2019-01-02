'use strict';

const Figures = (function () {

    let figures = {};

    function Figure(id) {
        if (id in figures) {
            return figures[id];
        } else {
            const figure = d3.select('body').append('div').attr('id',id)
                .style('position','absolute')
                .style('border','thin solid lightgrey')
                .style('left','50px')
                .style('top','50px')
                .style('width','700px')
                .style('height','450px')
                .style('box-shadow','3px 3px 5px lightgrey')
                .on('dblclick', function() {
                    close(id);
                })
            figure.call(d3.drag()
                .subject(function() { 
                    let x0 = figure.style('left');
                    let y0 = figure.style('top');
                    return {x: x0.substring(0,x0.length-2)*1, y: y0.substring(0,y0.length-2)*1};
                })
                .on('drag', function () {
                    figure.style('left', d3.event.x+'px')
                    figure.style('top',d3.event.y+'px')
                }));
            figures[id] = figure;
            return figure;
        }
    }

    function closeall() {
        d3.selectAll('div').remove();
        figures = {};
    }

    function close(id) {
        if (id in figures) {
            figures[id].remove();
            delete figures[id];
        }
    }

	const addget = function (c, name) {
		Object.defineProperty(c, name, {
			get: function () { return eval(name); },
			enumerable: true,
			configurable: true
		});
		return c;
	};

    let c = {};
    c = addget(c, 'figures');
    c = addget(c, 'Figure');
    c = addget(c, 'closeall');
    c = addget(c, 'close');
	return c;
})();
