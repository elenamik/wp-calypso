/**
 * Internal dependencies
 */
import { ActionType, SiteVertical, Vertical } from './types';
import { DomainSuggestion } from '../domain-suggestions/types';

export const setDomain = ( domain: DomainSuggestion ) => ( {
	type: ActionType.SET_DOMAIN as const,
	domain,
} );

export const setSiteVertical = ( siteVertical: SiteVertical ) => ( {
	type: ActionType.SET_SITE_VERTICAL as const,
	siteVertical,
} );

export const resetSiteVertical = () => ( {
	type: ActionType.RESET_SITE_VERTICAL as const,
} );

export const setSiteTitle = ( siteTitle: string ) => ( {
	type: ActionType.SET_SITE_TITLE as const,
	siteTitle,
} );

export const receiveVerticals = ( verticals: Vertical[] ) => ( {
	type: ActionType.RECEIVE_VERTICALS as const,
	verticals,
} );
