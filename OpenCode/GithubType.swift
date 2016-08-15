//
//  GithubType.swift
//  OpenCode
//
//  Created by 陈亮 on 16/8/15.
//  Copyright © 2016年 moonrailgun. All rights reserved.
//
//  detail:https://developer.github.com/v3/activity/events/types/

import Foundation

enum GithubType:String{
    case CommitCommentEvent = "CommitCommentEvent"
    case CreateEvent = "CreateEvent"
    case DeleteEvent = "DeleteEvent"
    case DeploymentEvent = "DeploymentEvent"
    case DeploymentStatusEvent = "DeploymentStatusEvent"
    case DownloadEvent = "DownloadEvent"
    case FollowEvent = "FollowEvent"
    case ForkEvent = "ForkEvent"
    case ForkApplyEvent = "ForkApplyEvent"
    case GistEvent = "GistEvent"
    case GollumEvent = "GollumEvent"
    case IssueCommentEvent = "IssueCommentEvent"
    case IssuesEvent = "IssuesEvent"
    case MemberEvent = "MemberEvent"
    case MembershipEvent = "MembershipEvent"
    case PageBuildEvent = "PageBuildEvent"
    case PublicEvent = "PublicEvent"
    case PullRequestEvent = "PullRequestEvent"
    case PullRequestReviewCommentEvent = "PullRequestReviewCommentEvent"
    case PushEvent = "PushEvent"
    case ReleaseEvent = "ReleaseEvent"
    case RepositoryEvent = "RepositoryEvent"
    case StatusEvent = "StatusEvent"
    case TeamAddEvent = "TeamAddEvent"
    case WatchEvent = "WatchEvent"
}