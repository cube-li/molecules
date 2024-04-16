% 定义线段的数据结构
classdef Segment
    properties
        start_x
        start_y
        end_x
        end_y
        poly
        inOut
        otherInOut
        non_con
    end
    
    methods
        function obj = Segment(start_x, start_y, end_x, end_y,poly,inOut,otherInOut,non_con)
            obj.start_x = start_x;
            obj.start_y = start_y;
            obj.end_x = end_x;
            obj.end_y = end_y;
            obj.poly = poly;
            obj.inOut = inOut;
            obj.otherInOut=otherInOut;
            obj.non_con=non_con;
        end
    end
end
