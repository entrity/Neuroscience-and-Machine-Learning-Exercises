global N = 20;

function r = myrand()
	n = 50;
	r = rand * 2 * n - n;
end

function s = mysign(val)
	s = sign(val) + (0 == val);
end

% Weights
global w = zeros(1,3)';
% base and 2 inputs (for 20 data points)
global x = [
		ones(1,N);
		arrayfun(@ myrand, 1:N);
		arrayfun(@ myrand, 1:N);
	];

% Line
global m = myrand
global b = myrand
global y = [];
for i = 1:N
	y(i) = x(3,i) >= x(2,i)*m + b;
end
y(find(y == 0)) = -1;

% Hypothesis, i.e. w'*x
function o = h(i)
	global w x
	o = mysign(w' * x);
	if exist('i', 'var')
		o = o(i);
	end
end

function render()
	global m b N x w
	h = w' * x;
	clf('reset')
	hold on
	axis([-60,60,-60,60]);
	p = find(h > 0);
	n = find(h < 0);
	scatter(x(2,p),x(3,p),8,'blue');
	scatter(x(2,n),x(3,n),8,'red');
	px = linspace(-50,50);
	py = px * m + b;
	plot(px, py);
end

function mm = find_mismatch()
	global w x N y
	for i = 1:N
		if y(i) ~= h(i)
			mm = i;
			return
		end
	end
	mm = 0;
end

% Find mismatch
iterations = 0;
for i = 1:N
	mm = find_mismatch;
	if mm
		iterations += 1;
		% printf('%2d mm %2d %2d\n', i, y(i), h(i))
		w = w + y(i) * x(:,i);
		render
		pause(0.07)
		% disp(w');
	end
end

m
b
iterations
render
w

if find_mismatch
	disp 'MISMATCH STILL EXISTS!!!!'
	save('dump', 'x', 'y', 'h', 'w', 'm', 'b', 'iterations')
	pause(60)
	input('press enter ')
else
	pause(2)
end