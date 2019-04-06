From: sashal@kernel.org (Sasha Levin)
Date: Sat, 6 Apr 2019 09:53:50 -0400
Subject: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
 "delayed" replies
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <20190406135350.GA2935@sasha-vm>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, Apr 05, 2019 at 11:47:31AM +0100, Patryk Mungai wrote:
>Dear All,
>
>When running dhcp tests using the 4.4.y (and 4.4.y-cip kernel as well), I
>encountered an issue where the dhcp client in the kernel could not get an
>IP address when multiple network devices were enabled. It seems that the
>current implementation of the dhcp client in the 4.4 kernel is send dhcp
>request via device 1 -> wait <1s for response from server on device 1 ->
>if no response, switch to device 2 -> repeat process on device 2 ...etc.
>When the dhcp server is slow to respond, this means it is impossible to get
>a dhcp address.
>
>This series backported from upstream fixes the issue, is it possible
>to apply this to 4.4.y and/or 4.4.y-cip?

This is something that seems more suited for the CIP kernel as it adds
new functionality.

--
Thanks,
Sasha
