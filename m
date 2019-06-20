From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 20 Jun 2019 20:51:46 +0100
Subject: [cip-dev] [cip-kernel-sec] report_affected: report cip branches
In-Reply-To: <20190620061309.1252-1-daniel.sangorrin@toshiba.co.jp>
References: <20190620061309.1252-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1561060306.21054.51.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-06-20 at 15:13 +0900, Daniel Sangorrin wrote:
> Allow reporting on cip branches, instead of returning an
> error like this one:
[...]
> ?def get_stable_branch(branch_name):
> -????match = _STABLE_BRANCH_RE.match(branch_name)
> -????return match and get_base_ver_stable_branch(match.group(1))
> +????if 'cip' in branch_name:
> +????????match = _CIP_BRANCH_RE.match(branch_name)
> +????????return match and get_base_ver_cip_branch(match.group(1))
> +????else:
> +????????match = _STABLE_BRANCH_RE.match(branch_name)
> +????????return match and get_base_ver_stable_branch(match.group(1))
[...]

Does this function actually need to know anything about specific branch
names?  It seems like we should be able to implement it as something
like:

    for branch in?get_live_branches():
        if branch['short_name'] == branch_name:
            return branch
    return None

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
