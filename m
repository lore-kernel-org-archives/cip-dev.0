From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 13 Jun 2017 14:15:54 +0200
Subject: [cip-dev] Request to create two new repositories
In-Reply-To: <592E5385.6030704@codethink.co.uk>
References: <592E5385.6030704@codethink.co.uk>
Message-ID: <593FD77A.1070904@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 31/05/17 07:24, Agustin Benito Bethencourt wrote:
> Hi,
>
> in order to start working on CIP testing Action 2, we will need to
> create a new repository to host tests and another one for logs.

It was requested at the last CIP TSC meeting that I provide further 
information for the needed repositories to be approved.

1.- We will need one repository to collect and store existing tests with 
Open Source licenses that are not included in the CIP charter.

Name: upstream-kernel-tests
Location: https://gitlab.com/cip-project/cip-testing

2.- We will need a repository to collect the tests developed within the 
CIP project, that will be published under CIP approved licenses.

Name: cip-kernel-tests
Location: https://gitlab.com/cip-project

3.- We will need a repository to collect the logs of the reference tests 
for each feature. From the compliance perspective, it is uncertain to me 
the license that these logs will have since it might be tied up to the 
license of the tests and the license of the code being tested. To reduce 
the risks I propose to add this repo in the Gitlab third party license 
code subgroup, cip-testing.

Name: CIP-kernel-test-logs
Location: https://gitlab.com/cip-project/cip-testing

Please consider this proposal for potential approval.

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
