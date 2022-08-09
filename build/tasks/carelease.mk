#
# Copyright (C) 2023 StatiXOS
# SPDX-License-Identifier: Apache-2.0
#

#
# CrookedAndroid Release Package (Builds OTA and Fastboot packages)
#

# Package names
CROOKED_TARGET_UPDATEPACKAGE := $(PRODUCT_OUT)/$(CROOKED_VERSION)-img.zip
CROOKED_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CROOKED_VERSION).zip

.PHONY: carelease
carelease: $(INTERNAL_UPDATE_PACKAGE_TARGET) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_UPDATE_PACKAGE_TARGET) $(CROOKED_TARGET_UPDATEPACKAGE)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CROOKED_TARGET_PACKAGE)
	@echo -e ${CL_GRN}"Success:" >&2

	@echo -e ${CL_CYN}""
	@echo -e ${CL_CYN}"   ______                 __            __"
	@echo -e ${CL_CYN}"  / ____/________  ____  / /_____  ____/ /"
	@echo -e ${CL_CYN}" / /   / ___/ __ \/ __ \/ //_/ _ \/ __  / "
	@echo -e ${CL_CYN}"/ /___/ /  / /_/ / /_/ / ,< /  __/ /_/ /  "
	@echo -e ${CL_CYN}"\______/   \____/\______/|_|\___/\__,_/ __"
	@echo -e ${CL_CYN}"   /   |  ____  ____/ /________  (_)___/ /"
	@echo -e ${CL_CYN}"  / /| | / __ \/ __  / ___/ __ \/ / __  / "
	@echo -e ${CL_CYN}" / ___ |/ / / / /_/ / /  / /_/ / / /_/ /  "
	@echo -e ${CL_CYN}"/_/  |_/_/ /_/\__,_/_/   \____/_/\__,_/   "
	@echo -e ${CL_CYN}" "
	@echo -e ${CL_YLW}"Device Name: $(TARGET_DEVICE)"
	@echo -e ${CL_GRN}"========================================================================="
	@echo "Fastboot: $(CROOKED_TARGET_UPDATEPACKAGE)" >&2
	@echo "Size: `du -h $(CROOKED_TARGET_UPDATEPACKAGE) | cut -f 1`"
	@echo "============================================================================"
	@echo "OTA: $(CROOKED_TARGET_PACKAGE)" >&2
	@echo "Size: `du -h $(CROOKED_TARGET_PACKAGE) | cut -f 1`"
	@echo "============================================================================"
	@echo -e ${CL_GRN}"========================================================================="
	@echo -e ${CL_RED}"Lets Get Crooked!"
