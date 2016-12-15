From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Thu, 15 Dec 2016 15:22:41 +0000
Subject: [cip-dev] CIP Developer update
Message-ID: <87y3zhcj3y.fsf@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

CIP developer update, we're including outstanding problems as gitlab
issues and there's more information at the issue links.

CIP

        - On retrieving build artifacts - we still have issues here. Is it
        the VM? have other cip-kernelci users seen this? We've tried manually
        entering other likely sounding URLs but without success.
             https://gitlab.com/cip-project/testing/issues/2
        - github branches have been created for the frontend repos to allow connections from the host
        to the VM, with that fork, bson isn't installing for the
        frontend - am investigating.
             https://gitlab.com/cip-project/testing/issues/3

LAVA
        We have created a VM server for LAVA testing; we're trying to get LAVA2
        tests to run - it currently doesn't see available devices.
             https://gitlab.com/cip-project/testing/issues/4

There'll be a face 2 face discussion between the developers tomorrow to
address the current issues

Robert
