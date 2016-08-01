var pathName = window.document.location.pathname;

/**
 * 公共提示信息接口
 * alert:没按钮的提示框
 * confirm:带按钮的提示框
 * info:没有标题和按钮的提示框，2秒自动关闭 
 */
var dggCharts = {
	pie: function(obj,name,data) {
		obj.highcharts({
		        chart: {
		            type: 'pie',
		            options3d: {
		                enabled: true,
		                alpha: 45,
		                beta: 0
		            }
		        },
		        title: {
		            text: ''
		        },
		        credits : {  
		            position: {//文字的位置 
		                x:-30,  
		                y:-30  
		            },  
		            enabled:false
		      }, 
		        tooltip: {
		        	formatter: function() {
			  	       	return '<b>'+ this.point.name +'</b>：' + 	Highcharts.numberFormat(this.y, 0, ',')+'条';
		  	       		}
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                depth: 45,
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
		                },
		                showInLegend: true
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: name,
		            data:data
		        }]
		    });
	},
	line: function(obj,name,categories,series) {
		obj.highcharts({
			chart: {
	            type: 'line',
	            zoomType:'x',
	            panning: true,
	            panKey: 'ctrl',
	            resetZoomButton: {
	                position: {
	                    x: -50,
	                    y: 5
	                }
	            }
	        },
	        title: {
	            text: name
	        },
	        credits : {  
	        enabled:false
	        }, 
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: categories
	        },
	        yAxis: {
	            title: {
	                text: '数量'
	            },
	            allowDecimals:false,
	        },
	        tooltip: {
	        	valueSuffix:'条'
	        },
	        plotOptions: {
	            line: {
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },
	        series: series
		    });
	}
};
