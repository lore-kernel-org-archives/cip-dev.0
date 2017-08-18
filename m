From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 18 Aug 2017 15:20:02 +0100
Subject: [cip-dev] Kernel feature support - core features and debugging
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445B9660D5@GSjpTKYDCembx31.service.hitachi.net>
References: <1500652489.12197.162.camel@codethink.co.uk>
	<04EAB7311EE43145B2D3536183D1A8445B9660D5@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <1503066002.2047.109.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2017-07-28 at 05:10 +0000, ???? / KAWAI?HIDEHIRO wrote:
> Hi Ben,
> 
> Thanks for the consideration and suggestion.
> 
> > From: Ben Hutchings
> > Performance events (CONFIG_PERF_EVENTS) provide a significant attack
> > surface and generally allow unprivileged users to crash the system.  If
> > you do need them enabled in production - which I can understand - you
> > might want to apply the Grsecurity/Debian/Android patch that disables
> > use by unprivileged users.
> 
> Is it difficult to support for super long term?  I think it is up to
> users to enable it or not.

I don't see backporting fixes as a major problem (though it might be).
However, most upstream security fixes have not even been marked as
needed in stable branches, and in several cases the flaws have been
exploited very quickly.  Given this record, I think that restricting it
to privileged users is risky and I don't think CIP should claim to be
able to provide security support.

> > User namespaces (CONFIG_USER_NS) open up a huge attack surface to
> > unprivileged users, which has resulted in a large number of privilege
> > escalation vulnerabilities.  This is enabled in the plathome_obsvx1,
> > siemens_iot2000 and siemens_server configs.  Do you need it?
> 
> I'm not sure how vulnerable it is, but I think we may want to adopt the
> same approach with the CONFIG_PERF_EVENTS case.
> https://github.com/copperhead/linux-hardened/commit/358b303ebdc0b4a74b66a41ddfd2a69322d5404a.patch

I agree, that's the same patch that Debian kernels have.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
