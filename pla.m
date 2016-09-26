N = 20;

function r = myrand()
	n = 50;
	r = rand * 2 * n - n;
end

function s = mysign(val)
	sign(val) + (0 == val)
end

% Weights
w = zeros(1,3)';
% base and 2 inputs (for 20 data points)
x = [
		ones(1,N);
		arrayfun(@ myrand, 1:N);
		arrayfun(@ myrand, 1:N);
	];
% disp(x);

% Line
global m = myrand
global b = myrand
y = [];
for i = 1:N
	y(i) = x(3,i) >= x(2,i)*m + b;
end
y(find(y == 0)) = -1;
% disp(y)

function render(x, w, h)
	global m b
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
	hold off
end


% Find mismatch
for i = 1:N
	% Hypothesis (w'*x)
	h = w' * x;
	if y(i) ~= h(i)
		% printf('%2d mm %2d %2d\n', i, y(i), h(i))
		w = w + y(i) * x(:,i);
		render(x, w, h)
		pause(0.07)
		% disp(w');
	end
end

render(x, w, h)
w
