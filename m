From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 27 Oct 2016 07:17:20 +0200
Subject: [cip-dev] Maintenance policies and early considerations IV
In-Reply-To: <57E3D5BA.2050905@codethink.co.uk>
References: <57E3D5BA.2050905@codethink.co.uk>
Message-ID: <26ff9cea-d6c2-39b5-43a9-b96ab373d6e6@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2016-09-22 14:59, Agustin Benito Bethencourt wrote:
> Hi,
> 
> at CIP we need to have a clear view of what "Support" means in the
> context of the Super Long Term Support kernel.
> 
> ++ What kind of support will CIP provide? To whom?
> 
> CIP will support its members and their developers, not system
> administrators or end users.  With the current number of members, there
> should not be a need for a 'first line' of support between them and the
> CIP core developers, though that may change if membership grows
> significantly.
> 
> Commercial Linux based distributions like RHEL promise that a subset of
> the kernel module API and ABI remains stable within a major release, so
> that many out-of-tree modules can be used without needing to update the
> module source or binaries along with the kernel.  Some IHVs rely on this
> to distribute driver modules in binary form.
> 
> CIP should avoid making any such promise because:
> 
> * Upstream fixes frequently change the kernel module API and/or ABI and
> backporting them in a way that does not is difficult and risky   - CIP
> users set their own kernel configurations, so there will not be a single
> kernel ABI for IHVs to target anyway
> 
> * CIP users are responsible for binary releases of both the kernel and
> out-of-tree modules, so can ensure that they are properly synchronised.
> 
> * The criteria for backporting bug fixes will presumably be based on
> 'stable-kernel-rules.txt'.  However, In CIP context, it is recommended
> to be more precise than that.
>

Nit: it's stable_kernel_rules.txt. We should start this way and
augment/adjust rules after discussions as we find potential conflicts.

Sounds reasonable to me in general.

Jan

-- 
Siemens AG
Corporate Technology
Research & Technology Center
CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
Otto-Hahn-Ring 6
81739 Muenchen
Tel.: +49 89 636-634006
Fax: +49 89 636-33045
mailto:jan.kiszka at siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard
Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief
Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina
Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin
and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB
12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
