SOURCES=\
	vector.erl\
	force.erl\
	inertia.erl\
	position.erl\
	particle.erl\

SOURCES_T=\
	  test/force_tests.erl\
	  test/inertia_tests.erl\
	  test/position_tests.erl\
	  test/vector_tests.erl\

COMP=erlc
EVAL=erl
EVALFLAGS=-noshell
TESTFLAGS=verbose

#######################
# AUTOMATIC VARIABLES #
#######################

ifndef mode
    mode=release
endif 
ifneq ($(mode), release)
ifneq ($(mode), test)
    $(error mode must be release or test)
endif
endif

ifeq ($(mode), release)
    m=R
endif
ifeq ($(mode), test)
    m=T
endif

ifdef SOURCES_$m
SOURCES:=$(SOURCES_$m) $(SOURCES)
endif

BUILD_DIR:=ebin/
OBJECTS:=$(addprefix $(BUILD_DIR),$(SOURCES:.erl=.beam))
TEST_MODULES:=$(notdir $(basename $(subst _tests,,$(SOURCES_T))))

# Ensures build_dir is created
$(shell for d in $(sort $(dir $(OBJECTS))); do \
     [ -d $$d ] || mkdir -p $$d; \
done)

#####################
# COMPILATION RULES #
#####################

.PHONY: compile, runtests, clean

compile: $(OBJECTS)

runtests: compile
	for object in $(TEST_MODULES); do erl $(EVALFLAGS) -pa $(BUILD_DIR) -pa $(BUILD_DIR)test -eval "eunit:test($$object,[$(TESTFLAGS)]), init:stop()." || exit 1; done

$(BUILD_DIR)%.beam: %.erl
	erlc -o $(@D) $<

clean:
	rm -fr $(BUILD_DIR)
