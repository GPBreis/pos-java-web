package br.edu.utfpr.cp.espjava.crudcidades;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filter(HttpSecurity http) throws Exception {
        return http
                .csrf().disable()
                .authorizeHttpRequests()
                .requestMatchers("/").hasAnyRole("listar", "admin")
                .requestMatchers("/criar", "/excluir", "/alterar", "/preparaAlterar").hasRole("admin")
                .requestMatchers("/mostrar").authenticated()
                .anyRequest().denyAll()
                .and()
                .formLogin()
                .loginPage("/login.html").permitAll()
                .and()
                .logout().permitAll()
                .and()
                .build();
    }

    @EventListener(ApplicationReadyEvent.class)
    public void printSenhas() {
        System.out.println(this.cifrador().encode("test123"));
    }

    @Bean
    public PasswordEncoder cifrador() {
        return new BCryptPasswordEncoder();
    }

    @EventListener(InteractiveAuthenticationSuccessEvent.class)
    public void printUsuarioAtual(InteractiveAuthenticationSuccessEvent event) {

        var usuario = event.getAuthentication().getName();

        System.out.println(usuario);
    }
}
