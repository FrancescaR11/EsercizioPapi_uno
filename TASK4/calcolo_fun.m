function [fun] = calcolo_fun(c,s,r,d,p)
fun=@(x) p*(+c*x-s*min(x,d)-r*max(0,x-d))
end

