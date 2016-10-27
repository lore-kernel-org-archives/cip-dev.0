From: hidehiro.kawai.ez@hitachi.com (Hidehiro Kawai)
Date: Thu, 27 Oct 2016 15:07:49 +0900
Subject: [cip-dev] Maintenance policies and early considerations I
In-Reply-To: <57E3A4F4.6050109@codethink.co.uk>
References: <57E3A4F4.6050109@codethink.co.uk>
Message-ID: <581199B5.5070000@hitachi.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

I'm sorry for the late response.

(2016/09/22 18:31), Agustin Benito Bethencourt wrote:
> Hi,
> 
> during the Technical Committee Meeting, last Monday, Ben Hutchings 
> brought to the attention of the participants several topics to consider. 
> I would like to bring them here. This is the first one
> 
> ++ When do CIP should pick up a kernel?
> 
> +++ Maintainability effort
> 
> New major versions of commercial Linux Distributions are released at 3-4 
> year intervals, so that typically only 4 versions need to be supported 
> at one time.  Given that CIP's support period is meant to be even 
> longer, it won?t be sustainable to extend every 'long term' branch, but 
> only takes on a new branch every 2-4 years.

Assuming we release new products in every 2 years, 2-3-year release
cycle would be feasible.

Maintaining multiple branches is hard work, but its effort would be
decreased after 5 years from the release.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

> +++ Backport effort
> 
> The longer the intervals between new CIP branches, the greater need 
> there will be for CIP or individual members to backport new hardware 
> support (which carries its own risks).
> 
> +++ Trade-off
> 
> This trade-off is perhaps the most difficult issue to decide.
> 
> 
> Best Regards
> 
