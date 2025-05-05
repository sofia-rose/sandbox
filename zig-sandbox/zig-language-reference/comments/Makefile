all: comments doc_comments tldoc_comments

comments: comments.zig
	zig build-exe $<

doc_comments: doc_comments.zig
	zig build-obj $<

tldoc_comments: tldoc_comments.zig
	zig build-obj $<

docs: doc_comments.zig
	zig test -femit-docs $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f comments
	rm -f doc_comments
	rm -rf docs
