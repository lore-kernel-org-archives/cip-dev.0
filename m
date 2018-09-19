From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 19 Sep 2018 14:32:49 +0100
Subject: [cip-dev] DebConf trip report
Message-ID: <1537363969.3024.234.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I attended DebConf (and the preceding DebCamp) in Taiwan in July-August 
this year, and met developers from several of the other CIP members.

As a sponsor of the event, CIP had a table set up in an open area to
promote itself (seen in <https://photos.app.goo.gl/mk9BdTAt3bHhtqVu6>).
There was a fair amount of traffic to these tables, but I don't know
how many people stopped to ask about CIP.

---

The CIP developers present met to discuss future maintenance of kernel
branches.  It was initially proposed that Nobuhiro Iwamatsu and others
would take over maintenance of the 4.4 branch, while I would provide
guidance to them as needed and would also start maintaining a new
branch based on the next longterm stable kernel.

I said that I did not wish to take on a new branch myself, and that I
thought having separate maintainers for the two branches would result
in duplicated effort.  My experience with maintaining two stable
branches at the same time is that much of the work done on one is
directly applicable to the other, so it doesn't take nearly twice as
much work as maintaining a single branch.  So I proposed instead that
Iwamatsu-san and the other new maintainers should take on both 4.4 and
the new branch, and I should only act as a mentor.  This was
provisionally accepted.

---

Yoshitake Kobayashi gave a talk about how Debian is used in civil
infrastructure, and about CIP specifically:
<https://debconf18.debconf.org/talks/112-civilization-runs-on-debian/>.
The talk itself is probably not news to anyone on this list.  There
were a fair number of attendees, who asked some interesting questions
(starting at around 35 minutes into the video).

Ian Jackson and Sean Whitton talked about a new tool called git-
debrebase, which implements a new approach to managing patches in
Debian packages
<https://debconf18.debconf.org/talks/60-git-debrebase-new-tool-for-managing-debian-packaging-in-git/>.
I think this has the potential to close the gap between normal git-
based development and Debian source packaging, for those trying to do
both.

I organised a BoF on "Building Debian-based system images"
<https://debconf18.debconf.org/talks/89-building-debian-based-system-images/>,
mostly concerned with comparing the different tools available. ?The
notes taken at this BoF are available at
<https://gobby.debian.org/export/debconf18/bof/building-debian-images>
and I intend to incorporate these into the Debian wiki later.

Relatedly, Kazuhiro Hayashi talked about "Build tools for applying
Debian to Embedded Systems"
<https://debconf18.debconf.org/talks/159-build-tools-for-applying-debian-to-embedded-systems/>
but I didn't attend.

I gave my annual talk on "What's new in the Linux kernel"
<https://debconf18.debconf.org/talks/91-whats-new-in-the-linux-kernel/>.
This is mostly concerned with how kernel changes relate to the rest of
the Debian system.

I organised a BoF on "Backporting hardware support in Debian", but not
many people participated in this.  There did not seem to be much
interest in spending more effort on backporting changes in individual
drivers.  It seems more likely that Debian will add support for
installing a stable release together with a newer kernel version. 
(This should not mean that the kernel team will refuse clean backports
to the stable kernel version, though.)

Steve McIntyre organised the regular BoF for Arm porters
<https://debconf18.debconf.org/talks/93-arm-ports-bof/>, but I didn't
attend it.  The notes taken at this BoF are at
<https://gobby.debian.org/export/debconf18/bof/arm-ports>.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
