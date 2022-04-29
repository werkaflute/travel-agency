﻿import React,{Component} from 'react';
import {Navbar,Nav} from 'react-bootstrap';
import {NavLink} from 'react-router-dom';
import { ReactComponent as Logo } from '../icons/logo.svg';

export class Navigation extends Component{

    render(){
        return(
            <Navbar bg="light" expand="lg" fixed={"top"} >
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="m-auto display-7">
                        <Logo width={64} height={64}/>
                        <NavLink className="d-inline p-3 text-primary text-decoration-none" to="/">
                            Strona główna
                        </NavLink>
                        <NavLink className="d-inline p-3 text-primary text-decoration-none" to="/offer">
                            Wszystko
                        </NavLink>
                        <NavLink className="d-inline p-3 text-primary text-decoration-none" to="/offer">
                            Wczasy
                        </NavLink>
                        <NavLink className="d-inline p-3 text-primary text-decoration-none " to="/offer">
                            Wycieczki objazdowe
                        </NavLink>
                    </Nav>
                    <Nav>
                        <NavLink className="d-inline p-3 text-primary text-decoration-none" to="/offer">
                            Zaloguj
                        </NavLink>
                    </Nav>
                </Navbar.Collapse>
            </Navbar>
        )
    }
}