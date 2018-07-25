From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 25 Jul 2018 13:31:41 +0100
Subject: [cip-dev] cip-dev progress report weeks 20 - 29
Message-ID: <871sbrbioi.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi! Here's a report on the Codethink CIP testing development over the
past few weeks.

CIP kernel testing

- The master of B at D now installs 2018.4 rather the latest from
  debian-backports making the tool more resilient to upstream changes
  and allowing us to evaluate an upstream change before it goes live.

- Also linked to the above the beaglebone black health check now uses an
  inline test; this both breaks the reliance upon an upstream test repos
  structure and making testing less dependent upon needing an internet connection.

- Renesas board - this hardware continued to not give consistent results in B at D
  tests so for the moment development has been suspended.

- Development has started on using docker containers for B at D - the
  kernelci one is up and kernel builds have successfully been uploaded
  to it, there is an outstanding issue with retrieving those builds from
  the container. Work is also being carried out on the lava docker container.

Robert
-- 
Robert Marshall, Software Developer                       Codethink Ltd
Telephone: +44 7762 840 414       3rd Floor, Dale House, 35 Dale Street
https://www.codethink.co.uk/         MANCHESTER, M1 2HF. United Kingdom
