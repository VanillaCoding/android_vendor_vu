#Since we wont follow CM trees 
for combo in $(cat vendor/vu/vu-build-targets)
do
    add_lunch_combo $combo
done
