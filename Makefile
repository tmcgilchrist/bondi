INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)
d := ~/.bondi

# Default rule
default:
	jbuilder build @install
	test -d $d || mkdir -p $d && cp -r prelude $d

install:
	jbuilder install $(INSTALL_ARGS)

uninstall:
	jbuilder uninstall $(INSTALL_ARGS)

reinstall: uninstall reinstall

clean:
	jbuilder clean

tests:
	test -d $d || mkdir -p $d && cp -r tests $d
	jbuilder clean && jbuilder runtest
	

.PHONY: default install uninstall reinstall clean tests