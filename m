From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 16 Mar 2018 08:46:27 +0000
Subject: [cip-dev] [Cip-testing-results] LAVA notification for Test Job
	72
In-Reply-To: <20180316074541.1233.62178@stretch.localdomain>
References: <20180316074541.1233.62178@stretch.localdomain>
Message-ID: <C7D59721-F8AC-453D-A867-C2D2CA9B89B5@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

in order for these mails to be useful (successful build/boot), beside the kernel version, which info would be useful to you?

On 16 March 2018 07:45:41 GMT+00:00, srv_ln001 at codethink.co.uk wrote:
>
>Hello,
>
>The job with ID # 72 is now in status Complete. Job was submitted by
>lava-health.
>
>Job details and log file: http://localhost/scheduler/job/72
>
>
>
>Device details:
>Hostname: bbb01
>Type: beaglebone-black
>Owner: lavauser
>Worker: stretch.localdomain
>
>Job details:
>Priority: Medium
>Visibility: Publicly visible
>Description: local test of ramdisk test on bbb
>Submitted: 2018-03-16 07:42:11 (+0000 UTC)
>Started: 2018-03-16 07:42:28 (+0000 UTC)
>Finished: 2018-03-16 07:45:00 (+0000 UTC)
>Duration: 0:02:31.960506
>
>Results:
>
>
>Test Suite lava: http://localhost/results/72/lava
>Test Case job: Test passed
>Test Case power-off: Test passed
>Test Case 0_smoke-tests: Test passed
>Measurement: 0.0900000000 seconds
>Test Case auto-login-action: Test passed
>Measurement: 105.2600000000 seconds
>Test Case send-reboot-commands: Test passed
>Measurement: 2.5500000000 seconds
>Test Case bootloader-overlay: Test passed
>Test Case test-runscript-overlay: Test passed
>Measurement: 0.0300000000 seconds
>Test Case test-install-overlay: Test passed
>Measurement: 0.0300000000 seconds
>Test Case test-overlay: Test passed
>Measurement: 0.0200000000 seconds
>Test Case git-repo-action: Test passed
>Measurement: 2.6500000000 seconds
>Test Case http-download: Test passed
>Measurement: 0.2600000000 seconds
>Test Case http-download: Test passed
>Measurement: 0.0100000000 seconds
>Test Case http-download: Test passed
>Measurement: 0.0500000000 seconds
>Test Case http-download: Test passed
>Measurement: 0.1200000000 seconds
>Test Case validate: Test passed
>No query is set for results comparing.
>
>LAVA
>Linaro Automated Validation Architecture
>_______________________________________________
>Cip-testing-results mailing list
>Cip-testing-results at lists.cip-project.org
>https://lists.cip-project.org/mailman/listinfo/cip-testing-results

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180316/e41e15eb/attachment.html>
