From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:43:15 +0000
Subject: [cip-dev] Improve Regression Tracking - Thorsten Leemhuis
In-Reply-To: <1510076438.2465.31.camel@codethink.co.uk>
References: <1510076438.2465.31.camel@codethink.co.uk>
Message-ID: <1510076595.2465.34.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

## Improve Regression Tracking - Thorsten Leemhuis

[Description](https://osseu17.sched.com/event/CnFn/)

Thorsten has started tracking regressions in the kernel, in his spare
time.??He is not a programmer but a journalist (for c't) and community
manager.??He started doing this because Linus said he would like to
see someone do the job which Rafael Wysocki used to.

He expected it to be hard and frustrating, and it's even worse than that!
He needs to search through LKML, subsystem MLs, multiple Bugzillas.
It's very time consuming and he's still missing a lot of regressions.

Discussion of a single issue might change forum and it's not obvious
so he doesn't see that.??An issue might get quietly resolved by commit
without any message to a bug tracker.

He requested people to use a regression ID (which he assigns) and put
it in discussions and commit messages.??This hasn't happened (yet).
Someone suggested to make wider use of `[REGRESSION]` for reports
of recent regressions.??(Both of the above should be added to in-tree
documentation.)

Someone suggested to add another mailing list specifically for
regression reports, that may be cc'd(?) along with specific ML.

The upstream bug reporting process differs a lot across subsystems -
frustrating for distribution maintainers forwarding reports.??It is
also hard to see current regression status of the next stable release
when considering whether to update the kernel package.

Regression tracking is also needed for the "long tail" of bugs that
don't get reported so quickly (within 1 or 2 release cycles).??This
will require a team of people, not just one.

There needs to be some kind of database to collect information, if
only references to discussions elsewhere.??Rafael used to create
tracking bugs on <https://bugzilla.kernel.org>.??Thorsten is using
a spreadsheet.


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
