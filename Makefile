BMv2_DIR=/home/netarchlab/behavioral-model/targets/simple_switch
MAIN_FILE=hyperv.p4
COMMIT_REASON=?"defaut commit"
LOG="--log-console"
INTF1="-i 1@p4p1" 
INTF2="-i 2@p4p2"


compile:
	@mkdir -p build
	@p4c-bmv2 src/${MAIN_FILE} --json build/hyperv.json
	@p4c-bmv2 tests/hyper4/p4src/hp4.p4 --json build/hyper4.json

clean:
	@rm -rf build
	@rm -rf build

test:
	@echo "TODO"

test-hyper4:
	@echo "TODO"	

git:
	@git add -A
	@git commit -a -m $COMMIT_REASON
	@git push -u origin master

run: 
	@cp build/hyperv.json $(BMv2_DIR)
	@cd $(BMv2_DIR)&&sudo bash simple_switch hyperv.json $(INTF1) $(INTF2) $(LOG)

run-hyper4:
	@cp build/hyper4.json $(BMv2_DIR)
	@cd $(BMv2_DIR)&&sudo bash simple_switch hyper4.json $(INTF1) $(INTF2) $(LOG)


setup:
	@cd tests&&sudo ./setup

fat-tree:
	@cp build/hyperv.json $(BMv2_DIR)
	@cp build/hyper4.json $(BMv2_DIR)
	@cd tools&&sudo bash fat-tree.sh
